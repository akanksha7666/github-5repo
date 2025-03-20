const { default: mongoose } = require("mongoose");
const ChatStart = require("../model/users_messages.model.js");
const {
	getUsersSocket,
	getUserByIdSocket,
	CreateChatSocket,
} = require("../sockets/chat.socket.js");

const create_chat = async (req, res) => {
	try {
		const { user_id } = req.requestor;
		const user = await getUserByIdSocket({ user_id });
		if (!user) {
			return res.status(404).json({
				status: "error",
				message: "User not found",
			});
		}

		if (user.status === "error") {
			return res.status(404).json({
				status: "error",
				message: user.message || "Something went wrong",
			});
		}

		const chatcreate = await ChatStart.create(
			{
				sender_id: user_id,
				receiver_id: req.body.receiver_id,
				content: req.body.content,
				message_type: req.body.message_type,
				is_seen: req.body.is_seen,
				seen_time: req.body.is_seen ? new Date() : null,
				created_by: user_id,
				updated_by: user_id,
			}
		);
		
		// const updatedUser = await CreateChatSocket({
		// 	user_id,
		// 	req: req.body,
		// 	created_by: req.requestor,
		// });

		// if (updatedUser.is_deleted) {
		// 	return res.status(200).json({
		// 		status: "success",
		// 		message: "User deleted successfully",
		// 	});
		// }

		res.status(200).json({
			status: "success",
			message: "Message send successfully",
			chatcreate,
		});
	} catch (error) {
		console.error("Error:", error);
		res.status(500).json({
			status: "error",
			message: "Internal server error",
		});
	}
};
// const create_chat = async (req, res) => {
// 	try {

// 		const { search, limit, page } = req.query;
// 		const data = await getUsersSocket({ search, limit, page });
// 		res.json({
// 			status: "success",
// 			message: "Users retrieved successfully.",
// 			data,
// 		});
// 	} catch (error) {
// 		console.error("Error:", error);
// 		res.status(500).json({
// 			status: "error",
// 			message: "Internal server error",
// 		});
// 	}
// };

// const getUserById = async (req, res) => {
// 	try {
// 		const { user_id } = req.params;

// 		const user = await getUserByIdSocket({ user_id });

// 		if (!user) {
// 			return res.status(404).json({
// 				status: "error",
// 				message: "User not found",
// 			});
// 		}

// 		if (user.is_deleted === true) {
// 			return res.status(404).json({
// 				status: "error",
// 				message: "User is deleted",
// 			});
// 		}

// 		res.json({
// 			status: "success",
// 			message: "Users retrieved successfully.",
// 			user,
// 		});
// 	} catch (error) {
// 		console.error("Error:", error);
// 		res.status(500).json({
// 			status: "error",
// 			message: "Internal server error",
// 		});
// 	}
// };

// const updateUserById = async (req, res) => {
// 	try {
// 		const { user_id } = req.params;

// 		const user = await getUserByIdSocket({ user_id });

// 		if (!user) {
// 			return res.status(404).json({
// 				status: "error",
// 				message: "User not found",
// 			});
// 		}

// 		if (user.status === "error") {
// 			return res.status(404).json({
// 				status: "error",
// 				message: user.message || "Something went wrong",
// 			});
// 		}

// 		const updatedUser = await updateUserByIdSocket({
// 			user_id,
// 			req: req.body,
// 			updatedBy: req.requestor,
// 		});

// 		if (updatedUser.is_deleted) {
// 			return res.status(200).json({
// 				status: "success",
// 				message: "User deleted successfully",
// 			});
// 		}

// 		res.status(200).json({
// 			status: "success",
// 			message: "User updated successfully",
// 			updatedUser,
// 		});
// 	} catch (error) {
// 		console.error("Error:", error);
// 		res.status(500).json({
// 			status: "error",
// 			message: "Internal server error",
// 		});
// 	}
// };

// const deleteUserById = async (req, res) => {
// 	try {
// 		const { user_id } = req.params;

// 		const user = await getUserByIdSocket({ user_id });

// 		if (!user) {
// 			return res.status(404).json({
// 				status: "error",
// 				message: "User not found",
// 			});
// 		}

// 		if (user.status === "error") {
// 			return res.status(404).json({
// 				status: "error",
// 				message: user.message || "Something went wrong",
// 			});
// 		}

// 		req.body = { ...user, is_deleted: true };

// 		await updateUserById(req, res);
// 	} catch (error) {
// 		console.error("Error:", error);
// 		res.status(500).json({
// 			status: "error",
// 			message: "Internal server error",
// 		});
// 	}
// };

module.exports = { 
	create_chat, 
	// getUserById, 
	// updateUserById, 
	// deleteUserById 
};
