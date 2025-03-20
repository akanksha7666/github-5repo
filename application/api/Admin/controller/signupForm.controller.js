const { default: mongoose } = require("mongoose");
const signupForm = require("../model/signupForm.model.js");
const SignupFormHistory = require("../model/signupFormHistory.model.js");
const Subscription = require("../model/subscription.model.js");

const getSignUpForms = async (req, res) => {
	try {
		const search = req.query.search;
		const page = parseInt(req.query.page, 10) || 1;
		const limit = parseInt(req.query.limit, 10) || 10;

		let query = {};

		if (typeof search === "string") {
			if (/[^a-zA-Z0-9 -]/.test(search)) {
				return res.json({
					status: "error",
					message: "Search cannot contain special characters",
				});
			}

			if (search === "true" || search === "false") {
				query.is_active = search === "true";
			} else if (search.trim() !== "") {
				query.slug = { $regex: new RegExp(search, "i") };
			}
		}

		const totalRecords = await signupForm.countDocuments({
			...query,
			is_deleted: false,
		});

		const data = await signupForm
			.find({ ...query, is_deleted: false })
			.skip((page - 1) * limit)
			.limit(limit);

		const totalPages = Math.ceil(totalRecords / limit);

		return res.status(200).json({
			status: "success",
			message: "Forms retrieved successfully",
			current_page: page,
			total_pages: totalPages,
			total_records: totalRecords,
			data,
		});
	} catch (error) {
		console.error("Error:", error);
		return res
			.status(500)
			.json({ status: "error", message: "Internal server error" });
	}
};

const GetByIDFormBySlugHandler = async (req, res) => {
	try {
		const { slug } = req.params;

		if (slug == "") {
			return res.status(404).json({ message: "Invalid request." });
		}

		const slugData = await signupForm.findOne({
			slug,
		});

		if (!slugData) {
			return res.status(404).json({ message: "Slug not found." });
		}

		if (slugData.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: "Slug is deleted",
			});
		}

		return res.status(200).json({
			status: "success",
			message: "Slug retrieved successfully",
			data: slugData,
		});
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({ message: "Internal server error" });
	}
};

const GetFormIDWiseForm = async (req, res) => {
	try {
		const { form_id } = req.params;

		if (form_id == "") {
			return res.status(404).json({ message: "Invalid request." });
		}

		const formData = await signupForm.findOne({
			form_id,
		});

		if (!formData) {
			return res.status(404).json({ message: "Form not found." });
		}

		if (formData.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: "Form is deleted",
			});
		}

		return res.status(200).json({
			status: "success",
			message: "Form retrieved successfully",
			data: formData,
		});
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({ message: "Internal server error" });
	}
};

const postFormBySlugHandler = async (req, res) => {
	const { slug, name, step } = req.body;

	try {
		const checkSlugDuplicate = await signupForm.findOne({ slug });
		const checkNameDuplicate = await signupForm.findOne({ name });

		if (checkSlugDuplicate && checkSlugDuplicate.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: `The slug exists in trash.`,
			});
		}

		if (checkSlugDuplicate) {
			return res.status(400).json({
				status: "error",
				message: "The slug already exists.",
			});
		}

		if (checkNameDuplicate && checkNameDuplicate.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: `The name exists in trash.`,
			});
		}

		if (checkNameDuplicate) {
			return res.status(400).json({
				status: "error",
				message: "The name already exists.",
			});
		}

		const getDefaultSubscription = await Subscription.findOne({
			is_default: true,
		});

		if (!getDefaultSubscription) {
			return res.status(400).json({
				status: "error",
				message: "Default subscription not found.",
			});
		}

		const data = await signupForm.create({
			slug,
			name,
			step,
			subscription_id: getDefaultSubscription.subscription_id,
			created_by: req.requestor.user_id,
			updated_by: req.requestor.user_id,
		});

		return res.status(200).json({
			status: "success",
			message: "Form created successfully.",
			data: data,
		});
	} catch (error) {
		console.error("Error: ", error);
		res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
	}
};

const updateSignUpFormById = async (req, res) => {
	const session = await mongoose.startSession();
	session.startTransaction();

	try {
		const { form_id } = req.params;
		const updateData = req.body;

		const formData = await signupForm
			.findOne({
				form_id,
			})
			.session(session);

		if (!formData) {
			return res.status(404).json({
				status: "error",
				message: "Form not found",
			});
		}

		if (formData.is_deleted) {
			return res.status(404).json({
				status: "error",
				message: "Form is deleted",
			});
		}

		if (updateData.subscription_id) {
			const checkSubscription = await Subscription.findOne({
				subscription_id: updateData.subscription_id,
			}).session(session);

			if (!checkSubscription) {
				return res.status(400).json({
					status: "error",
					message: "Subscription not found",
				});
			}
		}

		if (updateData.slug) {
			const checkSubscription = await signupForm
				.findOne({
					slug: updateData.slug,
				})
				.session(session);

			if (checkSubscription) {
				return res.status(400).json({
					status: "error",
					message: "slug already exists",
				});
			}
		}

		if (updateData.name) {
			const checkSubscription = await signupForm
				.findOne({
					name: updateData.name,
				})
				.session(session);

			if (checkSubscription) {
				return res.status(400).json({
					status: "error",
					message: "name already exists",
				});
			}
		}

		await SignupFormHistory.create(
			[
				{
					form_id: formData.form_id,
					slug: formData.slug,
					name: formData.name,
					step: formData.step,
					is_active: formData.is_active,
					is_deleted: false,
					subscription_id: formData.subscription_id,
					created_by: req.requestor.user_id,
					updated_by: req.requestor.user_id,
					createdAt: formData.createdAt,
					updatedAt: formData.updatedAt,
				},
			],
			{ session }
		);

		const updatedForm = await signupForm.findOneAndUpdate(
			{ form_id },
			{ ...updateData, updated_by: req.requestor.user_id },
			{ new: true, session }
		);

		await session.commitTransaction();
		session.endSession();

		return res.status(200).json({
			status: "success",
			message: "Form updated successfully",
			data: updatedForm,
		});
	} catch (error) {
		await session.abortTransaction();
		session.endSession();
		console.error("Error:", error);
		res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
	}
};

const deleteFormByFormId = async (req, res) => {
	const session = await mongoose.startSession();
	session.startTransaction();

	try {
		const { form_id } = req.params;

		const form = await signupForm.findOne({ form_id }).session(session);

		if (!form) {
			return res.status(404).json({
				status: "error",
				message: "Form not found",
			});
		}

		if (form.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: "Form already deleted.",
			});
		}

		await SignupFormHistory.create(
			[
				{
					form_id: form.form_id,
					slug: form.slug,
					name: form.name,
					step: form.step,
					is_active: form.is_active,
					subscription_id: form.subscription_id,
					created_by: req.requestor.user_id,
					updated_by: req.requestor.user_id,
					createdAt: form.createdAt,
					updatedAt: form.updatedAt,
				},
			],
			{ session }
		);

		await signupForm.findOneAndUpdate(
			{ form_id },
			{ is_deleted: true, updated_by: req.requestor.user_id },
			{ session }
		);

		await session.commitTransaction();
		session.endSession();

		return res.status(200).json({
			status: "success",
			message: "Form deleted successfully",
		});
	} catch (error) {
		await session.abortTransaction();
		session.endSession();
		console.error("Error:", error);
		return res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
	}
};


const GetBySlug = async (req, res) => {
	try {
		const { slug } = req.params;

		if (slug == "") {
			return res.status(404).json({ message: "Invalid request." });
		}

		const slugData = await signupForm.findOne({
			slug,
		});

		if (!slugData) {
			return res.status(404).json({ message: "Slug not found." });
		}

		if (slugData.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: "Slug is deleted",
			});
		}

		return res.status(200).json({
			status: "success",
			message: "Slug retrieved successfully",
			data: slugData,
		});
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({ message: "Internal server error" });
	}
};

const GetFormIDWiseRecord = async (req, res) => {
	try {
		const { form_id } = req.params;

		if (form_id == "") {
			return res.status(404).json({ message: "Invalid request." });
		}

		const formData = await signupForm.findOne({
			form_id,
		});

		if (!formData) {
			return res.status(404).json({ message: "Form not found." });
		}

		if (formData.is_deleted) {
			return res.status(400).json({
				status: "error",
				message: "Form is deleted",
			});
		}

		return res.status(200).json({
			status: "success",
			message: "Form retrieved successfully",
			data: formData,
		});
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({ message: "Internal server error" });
	}
};
module.exports = {
	getSignUpForms,
	postFormBySlugHandler,
	updateSignUpFormById,
	deleteFormByFormId,
	GetByIDFormBySlugHandler,
	GetBySlug,
	GetFormIDWiseForm,
	GetFormIDWiseRecord
};
