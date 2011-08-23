Extension { #name : #RBProgramNode }

{ #category : #'*gt-inspector' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite tree 
		title: 'Tree';
		rootsExpanded;
		display: [:anObject | {anObject} ];
		children: [:each | each children ];
		format: [:each | 
			String streamContents: [ :stream |
				stream
					nextPutAll: each class name;
					nextPut: $(;
					nextPutAll: ((each formattedCode truncateTo: 50) copyReplaceAll: String cr with: String space) ;
					nextPut: $)] ]
]
