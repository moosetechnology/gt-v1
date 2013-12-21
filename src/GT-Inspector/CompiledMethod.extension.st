Extension { #name : #CompiledMethod }

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorBytecodeIn: composite [
	<gtInspectorPresentationOrder: 40> 
	composite text 
		title: 'Bytecode';
		display: [:anObject | anObject symbolic ]
]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorIrIn: composite [
	<gtInspectorPresentationOrder: 35> 
	composite text 
		title: 'Ir';
		display: [ :anObject || string |
				string := anObject ir longPrintString.
				string copyFrom: 2 to: string size ]
]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorPragmasIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite tabulator 
		title: 'Pragmas';
		when: [ :x | x pragmas notEmpty ];
		with: [ :t |  
		t row: #pragmas; row: #methods.
		t transmit to: #pragmas; andShow: [:a | 
			a list
				title: 'Pragmas';
				display: [ :method | method pragmas ];
				when: [ :x | x pragmas notEmpty ] ].
		t transmit from: #pragmas; to: #methods; andShow: [:a | 
			a list 
				title: 'Methods';
				display: [ :pragma | 
					| methods | 
					methods := OrderedCollection new.
					Object withAllSubclassesDo: [ :each | 
						methods addAll: ((Pragma allNamed: pragma keyword in: each) collect: #method) ].
					methods ];
				format: #selector ]
			];
		startOn: self
]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite smalltalkCode 
		title: 'Source';
		smalltalkClass: [ self methodClass ];
		display: [ self getSource ];
		act: [ self browse ] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Browse'
]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorVariableValuePairs [
	| literalIndex |
	literalIndex := 0.
	^ OrderedCollection new 
		add: ( '_self' -> self);
		add: ( 'header' -> self headerDescription );
		addAll: ( self literals collect: [ :aLiteral | 'literal', ( literalIndex := literalIndex + 1 ) asString -> aLiteral ] );
		add: ( 'all bytecodes' -> self symbolic );
		yourself

]
