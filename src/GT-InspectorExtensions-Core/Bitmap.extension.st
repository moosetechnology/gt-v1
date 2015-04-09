Extension { #name : #Bitmap }

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap class >> gtExampleIconBits [
	<gtExample: 'Icon bits'>
	^ ThemeIcons current pharoIcon bits
]

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap >> gtInspectorItemsIn: composite [
	"No items presentation for a Bitmap"
]
