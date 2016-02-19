as yet unclassified
startSmppLinks
	"Load and start everything. We do not expect any message so we are not registering any handler."
	smppDeliveryLinks := omDatabase allDeliveryLinks.
	smppDeliveryLinks do: [:each |
		each start].