as yet unclassified
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'VoyageMongo' with: [
				spec repository: 'github://pharo-nosql/voyage:47d4673e871f086e0be5fc3a0235e17dbf56e2ad/mc'].
		spec baseline: 'MongoTalk' with: [
				spec repository: 'github://pharo-nosql/mongotalk/mc'].
		spec project: 'SMPP' with: [
				spec
					className: #ConfigurationOfSMPP;
					versionString: '10';
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
		spec project: 'TCAP' with: [
				spec
					className: #ConfigurationOfTCAP;
					versionString: '9';
					repository: 'http://smalltalkhub.com/mc/osmocom/TCAP/main' ].
		spec project: 'ASN1' with: [
				spec
					className: #ConfigurationOfASN1;
					versionString: '1';
					repository: 'http://smalltalkhub.com/mc/NorbertHartl/ASN1/main' ].
		spec project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('REST' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].

		spec package: #'ShortMessageCenter-Database' with: [
			spec requires: #('VoyageMongo' 'MongoTalk' 'OsmoLogging') ].
		spec package: #'ShortMessageCenter-Inserter' with: [
			spec requires: #('ShortMessageCenter-Database' 'OsmoLogging')].
		spec package: #'ShortMessageCenter-Delivery' with: [
			spec requires: #('ShortMessageCenter-Database' 'OsmoLogging' 'ASN1' 'TCAP')].
		spec package: #'ShortMessageCenter-REST' with: [
			spec requires: #('ShortMessageCenter-Database' 'ZincHTTPComponents' 'OsmoLogging')]].
