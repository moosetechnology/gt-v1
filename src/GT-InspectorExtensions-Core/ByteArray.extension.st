Extension { #name : #ByteArray }

{ #category : #'*GT-InspectorExtensions-Core' }
ByteArray class >> gtExampleSimple [
	<gtExample>
	^ #[2r1010 8r333 16rFF]
]

{ #category : #'*GT-InspectorExtensions-Core' }
ByteArray >> gtInspectorItemsIn: composite [
	"No items presentation for a ByteArray"
]
