Extension { #name : #BFMetaObjectContainer }

{ #category : #'*gt-adaptationsbrowser' }
BFMetaObjectContainer >> adaptedObjectsAsHashDictionary [
	|values|
	values := OrderedCollection new.
	objectsToMetaObjects allAssociationsDo: [:assoc | 
		values add: (assoc key identityHash ->  (assoc key printString contractTo: 50)) ].
	^ values
	
]

{ #category : #'*gt-adaptationsbrowser' }
BFMetaObjectContainer >> metaObjectForHash: aHash [
	objectsToMetaObjects allAssociationsDo: [:assoc |  (assoc key identityHash = aHash) ifTrue: [^ assoc value] ].
	^ BFNullMetaObject new.
]
