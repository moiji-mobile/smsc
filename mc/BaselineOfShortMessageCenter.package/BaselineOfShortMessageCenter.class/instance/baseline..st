as yet unclassified
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec project: 'MongoTalk' with: [
				spec
					className: #ConfigurationOfMongoTalk;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main/' ].
		spec project: 'SMPP' with: [
				spec
					className: #ConfigurationOfSMPP;
					versionString: '2';
					repository: 'http://smalltalkhub.com/mc/osmocom/SMPP/main/' ].
		spec project: 'StatsDClient' with: [
				spec
					className: #ConfigurationOfStatsDClient;
					versionString: '3';
					repository: 'http://smalltalkhub.com/mc/hfreyther2/StatsD/main/' ].
		spec project: 'OsmoLogging' with: [
				spec
					className: #ConfigurationOfOsmoLogging;
					versionString: '1';
					repository: 'http://smalltalkhub.com/mc/osmocom/Logging/main/' ].
		spec project: 'ShortMessage' with: [
				spec
					className: #ConfigurationOfShortMessage;
					versionString: '1';
					repository: 'http://smalltalkhub.com/mc/osmocom/ShortMessage/main/' ].

		spec package: #'ShortMessageCenter-Database' with: [
			spec requires: #('MongoTalk' 'OsmoLogging') ].
		spec package: #'ShortMessageCenter-Inserter' with: [
			spec requires: #('ShortMessageCenter-Database' 'OsmoLogging') ]].