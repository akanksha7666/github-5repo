const { Router } = require("express");
const {
	loginHandler,
	verifyOtpHandler,
	forgotPasswordHandler,
	resetPasswordHandler,
	getsignupform,
	signup_form,
} = require("../controller/auth.controller.js");

const {
	maintenanceCheck,
	versionCheck,
} = require("../controller/maintenance.controller.js");
const { validateRequest } = require("../middleware/validation.middleware.js");
const loginSchema = require("../schema/login.schema.js");
const otpSchema = require("../schema/otp.schema.js");
const forgotPasswordSchema = require("../schema/forgotPassword.schema.js");
const resetPasswordSchema = require("../schema/resetPassword.schema.js");
const {
	checkEncrypted,
} = require("../middleware/encryptedCheck.middleware.js");

const router = Router();

router.post(
	"/login",
	validateRequest(loginSchema),
	checkEncrypted(),
	loginHandler
);
router.post(
	"/verify-otp",
	validateRequest(otpSchema),
	checkEncrypted(),
	verifyOtpHandler
);
router.get("/maintenance-check", maintenanceCheck);
router.post("/version-check", versionCheck);
router.post(
	"/forgot-password",
	validateRequest(forgotPasswordSchema),
	checkEncrypted(),
	forgotPasswordHandler
);
router.post(
	"/reset-password",
	validateRequest(resetPasswordSchema),
	checkEncrypted(),
	resetPasswordHandler
);

router.post("/get-signup-form/:slug", getsignupform);
router.post("/signup-form", signup_form);

const authRouter = router;
module.exports = authRouter;
