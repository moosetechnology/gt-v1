Extension { #name : #XMLElement }

{ #category : #'*GT-SpotterExtensions-Core' }
XMLElement classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode nodes firstElement 
]
