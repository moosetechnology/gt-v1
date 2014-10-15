Extension { #name : #CompiledMethod }

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod class >> gtExampleSimple [
	<gtExample>
	^ self class>>#gtExampleSimple
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorASTIn: composite [
	<gtInspectorPresentationOrder: 35> 
	(GTSimpleRBTreeBrowser new treeIn: composite)
		title: 'AST';
		display: [ :anObject | {anObject ast} ]
		
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorBytecodeIn: composite [
	<gtInspectorPresentationOrder: 40> 
	composite text 
		title: 'Bytecode';
		display: [ self symbolic ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorBytesIn: composite [
	<gtInspectorPresentationOrder: 30>
	"It makes no sense to view me as a collection of bytes"
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorIrIn: composite [
	<gtInspectorPresentationOrder: 35> 
	composite text 
		title: 'Ir';
		display: [ :anObject || string |
				string := anObject ir longPrintString.
				string copyFrom: 2 to: string size ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorItemsIn: composite [
	"It makes no sense to view me as a collection of items"
]

{ #category : #'*GT-InspectorExtensions-Core' }
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
					format: #selector ].
			t transmit
				toOutsidePort: #selection;
				from: #methods port: #selection
		];
		startOn: self
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30> 
	^ composite smalltalkCode 
		title: 'Source';
		smalltalkClass: [ self methodClass ];
		display: [ self getSource ];
		act: [ self browse ] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Browse'
]

{ #category : #'*GT-InspectorExtensions-Core' }
CompiledMethod >> gtInspectorVariableValuePairs [
	| literalIndex |
	literalIndex := 0.
	^ Set new 
		add: ( 'header' -> self headerDescription );
		addAll: ( self literals collect: [ :aLiteral | 'literal', ( literalIndex := literalIndex + 1 ) asString -> aLiteral ] );
		add: ( 'all bytecodes' -> self symbolic );
		yourself

]
