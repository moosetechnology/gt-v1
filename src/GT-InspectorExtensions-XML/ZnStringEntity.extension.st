Extension { #name : #ZnStringEntity }

{ #category : #'*GT-InspectorExtensions-XML' }
ZnStringEntity >> gtInspectorXmlIn: composite [
	<gtInspectorPresentationOrder: 40>
	| xml |
	xml := [XMLDOMParser parse: self string]
		on: XMLWellFormednessException
		do: [ ^ self ].
	xml gtInspectorTreeIn: composite
]
