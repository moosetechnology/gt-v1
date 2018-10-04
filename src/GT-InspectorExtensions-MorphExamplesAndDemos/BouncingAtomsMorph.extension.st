Extension { #name : #BouncingAtomsMorph }

{ #category : #'*GT-InspectorExtensions-MorphExamplesAndDemos' }
BouncingAtomsMorph classSide >> gtInspectorLiveIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite tabulator 
		title: 'Live';
		with: [ :t |
		t column: #morph; column: #atoms.
		t transmit to: #morph; andShow: [ :a | a morph ].
		t transmit to: #atoms; andShow: [ :a | 
			a list 
				display: #submorphs;
				format: [ :each :morph | 
					'Atom ', (morph submorphs indexOf: each) asString "bounds topLeft asString" ] ].
		t transmit from: #atoms; toOutsidePort: #selection. ];
		startOn: self new
]
