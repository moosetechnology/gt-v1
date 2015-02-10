Extension { #name : #Bitmap }

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap >> gtInspectorItemsIn: composite [
	"No items presentation for a Bitmap"
]

{ #category : #'*GT-InspectorExtensions-Core' }
Bitmap class >> iconBitsExample [
	<example: 'Icon bits'>
	^ ThemeIcons current pharoIcon bits
]
