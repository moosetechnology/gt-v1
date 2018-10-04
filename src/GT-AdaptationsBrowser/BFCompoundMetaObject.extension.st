Extension { #name : #BFCompoundMetaObject }

{ #category : #'*gt-adaptationsbrowser' }
BFCompoundMetaObject >> commands [
	^ self metaObjects inject: OrderedCollection new into: [ :commands :aMetaObject | commands addAll: aMetaObject commands; yourself ]
]
