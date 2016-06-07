module FlashHelper
	FLASH_CLASSES = {
		notice: "alert-info",
		success: "alert-success",
		alert: "alert-danger",
		error: "alert-danger"
	}

	def flash_class(level)
		FLASH_CLASSES[level]
	end
end