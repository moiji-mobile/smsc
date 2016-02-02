baselines
baseline01: spec
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec project: 'MongoTalk' with: [
				spec
					className: #ConfigurationOfMongoTalk;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main/' ].
		spec package: #'ShortMessageCenter-Database'. ].
