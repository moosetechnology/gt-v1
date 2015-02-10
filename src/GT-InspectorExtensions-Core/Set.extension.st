Extension { #name : #Set }

{ #category : #'*GT-InspectorExtensions-Core' }
Set >> gtInspectorItemsIn: composite [
	"we override this because sets do not work well in morph tree morphs" 
	^ (super gtInspectorItemsIn: composite)
		display: [:set | set asOrderedCollection]
]

{ #category : #'*GT-InspectorExtensions-Core' }
Set class >> simpleExample [
	<example: 'Simple'>
	^ #('fourtytwo' 42) asSet
]
