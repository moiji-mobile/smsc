as yet unclassified
startSS7Links
	| ss7Links |

	ss7Links := omDatabase allDeliverySS7Links.

	ss7Links do: [:link |
		| tcap |
		tcap := TCAPServiceEndPoint new.
		tcap asn1Model: self class asn1Model.
		tcap addHandler: (TCAPDialogueTimeoutHandler new
									timeout: 5 minutes;
									yourself).
		tcap networkService: link.
		tcapLinks at: link connectionName put: tcap.
		link start].