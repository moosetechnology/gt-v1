Extension { #name : #RBAbstractCondition }

{ #category : #'*GT-InspectorExtensions-Core' }
RBAbstractCondition >> gtInspectorChildren [
	^ #()
]

{ #category : #'*GT-InspectorExtensions-Core' }
RBAbstractCondition >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite tree
		title: 'Tree';
		display: [ { self } ]	;
		children: [ :each | each gtInspectorChildren ]
]
