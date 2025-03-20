const { default: mongoose } = require("mongoose");
const UserProfile = require("../model/userProfile.model.js");
const SignupFormHistory = require("../model/userProfileHistory.model.js");
const { getAuthenticationData } = require("../sockets/auth.socket");

const user_profile_match = async (req, res) => {
	const { user_id_2 } = req.body;
	try {
		const ConectedData = await UserProfile.findOne({
			user_id_1:req.requestor.user_id,
			user_id_2:user_id_2
		});
	
		if(ConectedData){
			var userData = await getAuthenticationData({ user_id: user_id_2});
			return res.status(200).json({
				status: "success",
				message: "Already connected.",
				match_data: {user_id_1: ConectedData.user_id_1,user_id_2: ConectedData.matched_id,matched_id: ConectedData.matched_id,status: ConectedData.is_active},
				match_user: userData,
			});
		}else{
			const ConectedRecord = await UserProfile.create({
				user_id_1:req.requestor.user_id,
				user_id_2:user_id_2
			});
			const userData = await getAuthenticationData({ user_id: user_id_2});
			if (!userData) {
				return res.status(404).json({
					status: "error",
					message: "Record not found.",
					data: userData,
				});
			}

			return res.status(200).json({
				status: "success",
				message: "Form created successfully.",
				match_data: {user_id_1: ConectedRecord.user_id_1,user_id_2: ConectedRecord.matched_id,matched_id: ConectedRecord.matched_id,status: ConectedRecord.is_active},
				match_user: userData,
			});
		}
	} catch (error) {
		res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
	}
};


const getconnected = async (req, res) => {
	try {
		const ConectedData = await UserProfile.findOne({
			user_id_1:req.requestor.user_id,
		});
	
		if(ConectedData){
			return res.status(200).json({
				status: "success",
				message: "Already connected.",
				match_data: {user_id_1: ConectedData.user_id_1,user_id_2: ConectedData.matched_id,matched_id: ConectedData.matched_id,status: ConectedData.is_active}
			});
		}else{
			return res.status(404).json({
				status: "error",
				message: "Record not found.",
				data: ConectedData,
			});
		}
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({ message: "Internal server error" });
	}
};

const GetUserProfileByID = async (req, res) => {
	const { user_id_2 } = req.params;
	try {
		const ConectedData = await UserProfile.findOne({
			user_id_1:req.requestor.user_id,
			user_id_2:user_id_2
		});
	
		if(ConectedData){
			var userData = await getAuthenticationData({ user_id: user_id_2});
			return res.status(200).json({
				status: "success",
				message: "Already connected.",
				match_data: {user_id_1: ConectedData.user_id_1,user_id_2: ConectedData.matched_id,matched_id: ConectedData.matched_id,status: ConectedData.is_active},
				match_user: userData,
			});
		}else{
			
				return res.status(404).json({
					status: "error",
					message: "Record not found.",
					data: userData,
				});
			
		}
	} catch (error) {
		res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
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

const deleteProfileByID = async (req, res) => {
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
	getconnected,
	user_profile_match,
	updateSignUpFormById,
	deleteProfileByID,
	GetByIDFormBySlugHandler,
	GetUserProfileByID,
	GetFormIDWiseForm,
	GetFormIDWiseRecord
};
