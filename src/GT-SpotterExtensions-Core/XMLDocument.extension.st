Extension { #name : #XMLDocument }

{ #category : #'*GT-SpotterExtensions-Core' }
XMLDocument classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDOMParser parse: '<document><a></a><b></b></document>'
]
