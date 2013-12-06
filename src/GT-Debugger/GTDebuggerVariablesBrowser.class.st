"
GTDebuggerVariablesBrowser is a special browser that is used in the first pane of the inspector that is embedded in the debugger. Its main intention is to provide a unified list of variables that come from:
- the instance variables of the receiver
- the local variables from the context
"
Class {
	#name : #GTDebuggerVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Debugger'
}

{ #category : #building }
GTDebuggerVariablesBrowser >> compose [  
	self title: [:each | GTInspector new printObjectAsAnItem: each receiver ].
	self morphicAct: [:anotherComposite | anotherComposite entity receiver browse]
				icon: GLMUIThemeExtraIcons glamorousBrowse 
				entitled: 'Browse'.
	self tabulator with: [:browser | 
		browser row: #variables.
		browser transmit to: #variables; andShow: [:a | 
			self variablesIn: a ].
		browser transmit from: #variables; toOutsidePort: #selection.
		"browser transmit from: #variables; toWatcher; andShow: [ :a :object | 
			a custom: (GTInspector new startOn: object) ]" ]
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> evaluatorIn: composite [
	(composite smalltalkCode)
		doItReceiver: [ :methodContext | methodContext receiver ] ;
		display: [ :methodContext | methodContext receiver ];
		format: [ :receiver | 
			[receiver printString asSmalltalkComment, String cr, 'self'] 
				on: Error 
				do: ['"Error printing. Try self printString to debug"'] ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text | 
				Compiler evaluate: text selectedText for: text displayValue logged: false ]
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesIn: composite [
	composite table
		showOnly: 50;
		display: [ :context | context gtDebuggerRetrieveVariableValuePairs ];
		sorted: [:variablePair1 :variablePair2 | variablePair1 key < variablePair2 key];
		column: 'Variable' evaluated: [:assoc | 
			[ Text fromString: assoc key asString ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		column: 'Value' evaluated: [:assoc | 
			[ Text fromString: (assoc value printString contractTo: 50) ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
"		icon: [ :each |
			each value class theNonMetaClass browserIcon
				ifNotNil: [ OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ] ];"
		send: #value;
		morphicSelectionAct: [:each | each value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect'
]
