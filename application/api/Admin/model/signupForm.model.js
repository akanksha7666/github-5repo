const mongoose = require("mongoose");
const { v4: uuidv4 } = require("uuid");

const fieldSchema = new mongoose.Schema({
	name: { type: String, required: true },
	type: { type: String, required: true },
	label: { type: String, required: true },
	placeholder: { type: String, required: true },
	required: { type: Boolean, required: true },
	validation: {
		minlength: { type: Number, required: false },
		maxlength: { type: Number, required: false },
	},
});

const stepSchema = new mongoose.Schema({
	step: { type: Number, required: true },
	title: { type: String, required: true },
	previous_button_text: { type: String, required: true },
	next_button_text: { type: String, required: true },
	fields: [fieldSchema],
});

const signupFormSchema = new mongoose.Schema(
	{
		form_id: {
			type: String,
			default: uuidv4,
			unique: true,
		},
		subscription_id: {
			type: String,
			required: true,
		},
		slug: {
			type: String,
			required: true,
			unique: true,
		},
		name: {
			type: String,
			required: true,
			unique: true,
		},
		step: [stepSchema],
		is_active: {
			type: Boolean,
			default: true,
			required: true,
		},
		is_deleted: {
			type: Boolean,
			default: false,
			required: true,
			comment: "0-NoDeleted, 1-Deleted",
		},
		created_by: {
			type: String,
			required: true,
		},
		updated_by: {
			type: String,
			required: true,
		},
	},
	{ timestamps: true }
);

module.exports = mongoose.model("SignupForm", signupFormSchema);
