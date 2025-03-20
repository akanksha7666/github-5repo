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

const signupFormHistorySchema = new mongoose.Schema(
	{
		form_history_id: {
			type: String,
			default: uuidv4,
			unique: true,
		},
		form_id: {
			type: String,
			required: true,
		},
		subscription_id: {
			type: String,
			required: true,
		},
		slug: {
			type: String,
			required: true,
		},
		name: {
			type: String,
			required: true,
		},
		step: [stepSchema],
		is_deleted: {
			type: Boolean,
			default: true,
			required: true,
			comment: "0-NoDeleted, 1-Deleted",
		},
		is_active: {
			type: Boolean,
			default: true,
		},
		created_by: {
			type: String,
			required: false,
		},
		createdAt: {
			type: String,
			required: false,
		},
		updated_by: {
			type: String,
			required: false,
		},
		updatedAt: {
			type: String,
			required: false,
		},
	},
	{ timestamps: true }
);

module.exports = mongoose.model("SignupFormHistory", signupFormHistorySchema);
