Extension { #name : #Set }

{ #category : #'*GT-InspectorExtensions-Core' }
Set class >> gtExampleSimple [
	<gtExample>
	<label: 'Simple'>
	
	^ #('fourtytwo' 42) asSet
]

{ #category : #'*GT-InspectorExtensions-Core' }
Set >> gtInspectorItemsIn: composite [
	"we override this because sets do not work well in morph tree morphs" 
	^ (super gtInspectorItemsIn: composite)
		display: [:set | set asOrderedCollection]
]
