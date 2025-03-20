const Maintenance = require("../model/maintenance.model.js");
const VersionManagement = require("../model/version_management.model.js");
// const { decryptData, encryptData } = require("../utils/security.util.js");
// const { generateAccessToken } = require("../utils/token.util.js");
const maintenanceCheck = async (req, res) => {
	try {
			const currentTime = new Date();
			const maintenance = await Maintenance.find({
				is_active: true,
				is_deleted: false,
				start_time: { $lte: currentTime },
      			end_time: { $gte: currentTime },
			});

		  if (!maintenance) {
			return res.status(200).json({ message: "No maintenance found." });
		  } else {
			return res.status(400).json({ message: "Currently server is maintenance mode" });
		  }
	} catch (error) {
		return res.status(500).json({ message: "Internal server error" });
	}
};

const versionCheck = async (req, res) => {
	try {	
		//1 Check valid version
		const ValidVersion = await VersionManagement.findOne({
			version:req.body.Version
		});

		if (!ValidVersion) {
			return res.status(404).send({ErrorCode: 'NOTFOUND', ErrorMessage: 'Version is not found.'});
		}

		//2 Latest Version
		const latestVersion = await VersionManagement.findOne({
		}).sort({ release_date: -1 });

		if (!latestVersion) {
			return res.status(404).send({ ErrorCode: 'NOTFOUND', ErrorMessage: 'Not any version found.' });
		}
		
		//3 Latest Version
		const SupportVersion = await VersionManagement.countDocuments({
			supported_versions: latestVersion.version,
			version : req.body.Version
		});

		if(latestVersion.version == req.body.Version){
			return res.status(200).send({ Update: 'Not required to update. you have latest version app', Status: 0, Message: latestVersion });
		}
		else if(SupportVersion > 0){
			return res.status(200).send({ Update: 'Not compalsary update', Status: 2, Message: latestVersion });
		}else{
			return res.status(200).send({ Update: 'force update', Status: 1, Message: latestVersion });
		}
	} catch (error) {
		return res.status(500).json({ ErrorCode: 'DATABASE_ERROR', ErrorMessage: "Internal server error" });
	}
};
module.exports = {maintenanceCheck, versionCheck};
