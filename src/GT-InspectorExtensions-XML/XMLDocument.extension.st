Extension { #name : #XMLDocument }

{ #category : #'*GT-InspectorExtensions-XML' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]
