as yet unclassified
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec project: 'MongoTalk' with: [
				spec
					className: #ConfigurationOfMongoTalk;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main/' ].
		spec package: #'ShortMessageCenter-Database' with: [
			spec requires: 'MongoTalk' ]].
