Extension { #name : #StackDebugAction }

{ #category : #'*GT-Debugger' }
StackDebugAction classSide >> gtStackActionsFor: aDebugger [
	<gtDebuggingAction>
	
	^ { 
		(self forDebugger: aDebugger)
			label: 'Step Into';
			action: #stepInto:;
			icon: GLMUIThemeExtraIcons glamorousInto;
			order: 20.
			
		(self forDebugger: aDebugger)
			label: 'Step Over';
			action: #stepOver:;
			icon: GLMUIThemeExtraIcons glamorousOver;
			order: 25.
			
		(self forDebugger: aDebugger)
			label: 'Step Through';
			action: #stepThrough:;
			icon: GLMUIThemeExtraIcons glamorousThrough;
			order: 30.
	 }
]
