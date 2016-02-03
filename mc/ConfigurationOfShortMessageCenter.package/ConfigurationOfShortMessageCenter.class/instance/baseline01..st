baselines
baseline01: spec
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repositories: [
			spec repository: self repositoryDir].
		spec project: 'MongoTalk' with: [
				spec
					className: #ConfigurationOfMongoTalk;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main/' ].
		spec package: #'ShortMessageCenter-Database'. ].
