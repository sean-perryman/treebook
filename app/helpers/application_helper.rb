module ApplicationHelper
	def flash_class(type)
		case type
		when "alert"
			"alert-danger"
		when "notice"
			"alert-info"
		else
			"alert-success"
		end
	end
end
