Extension { #name : #WhereIsDebugAction }

{ #category : #'*GT-Debugger' }
WhereIsDebugAction class >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousSearch
]

{ #category : #'*GT-Debugger' }
WhereIsDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		selector: #updateSelectionInterval
]
