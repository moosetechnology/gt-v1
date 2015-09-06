Extension { #name : #MethodModified }

{ #category : #'*GT-InspectorExtensions-Core' }
MethodModified class >> gtExampleMethodModified [
	" this is a fake annoucement, we just pick 2 arbitrary methods "
	<gtExample>
	<label: 'Diff old and new method'>
	
	^ MethodModified new 
		oldMethod: (MethodModified >> #gtMethodDiffIn:);
		method: (MethodModified class >> #gtExampleMethodModified);
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
MethodModified >> gtMethodDiffIn: aComposite [
	<gtInspectorPresentationOrder: 40>
	aComposite diff
		title: 'Diff';
		display: [ 
			Array 
				with: self newMethod sourceCode
				with: self oldMethod sourceCode ]

]
