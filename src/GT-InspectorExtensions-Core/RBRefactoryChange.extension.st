Extension { #name : #RBRefactoryChange }

{ #category : #'*GT-InspectorExtensions-Core' }
RBRefactoryChange class >> gtExampleEmpty [
	<gtExample>
	
	^ self new
]

{ #category : #'*GT-InspectorExtensions-Core' }
RBRefactoryChange >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite diff
		title: 'Changes';
		display: [ { self oldVersionTextToDisplay . self textToDisplay } ]
]
