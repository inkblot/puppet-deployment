Facter.add(:deploy_key) do
	setcode do
		if File.file?('/root/.ssh/id_deploy')
			IO.read('/root/.ssh/id_deploy')
		else
			''
		end
	end
end
