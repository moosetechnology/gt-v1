Extension { #name : #Bitmap }

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap class >> gtExampleIconBits [
	<gtExample>
	<label: 'Icon bits'>
	^ (Smalltalk ui icons iconNamed: #pharoIcon) bits
]

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap >> gtInspectorItemsIn: composite [
	"No items presentation for a Bitmap"
]
