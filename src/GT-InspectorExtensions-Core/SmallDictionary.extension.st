Extension { #name : #SmallDictionary }

{ #category : #'*GT-InspectorExtensions-Core' }
SmallDictionary >> gtInspectorItemsIn: composite [
	"we override this because sets do not work well in morph tree morphs" 
	^ (super gtInspectorItemsIn: composite)
		display: [:smallDictionary  | smallDictionary associations asOrderedCollection]
]
