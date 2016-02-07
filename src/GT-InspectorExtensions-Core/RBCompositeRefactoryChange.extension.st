Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GT-InspectorExtensions-Core' }
RBCompositeRefactoryChange >> gtInspectorPreviewIn: composite [
	composite list 
		title: 'Preview';
		display: [ self changes ]
]
