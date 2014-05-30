module ApplicationHelper
	def flash_class(type)
		case type
		when "alert"
			"alert-danger"
		when "error"
			"alert-danger"
		when "notice"
			"alert-info"
		else
			"alert-success"
		end
	end
end
