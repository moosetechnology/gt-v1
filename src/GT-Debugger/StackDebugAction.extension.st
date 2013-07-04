Extension { #name : #StackDebugAction }

{ #category : #'*GT-Debugger' }
StackDebugAction classSide >> gtStackActions [
	<gtDebuggingAction>
	
	^ { 
		self new
			label: 'Step Into';
			action: #stepInto:;
			icon: GLMUIThemeExtraIcons glamorousInto;
			order: 20.
			
		self new
			label: 'Step Over';
			action: #stepOver:;
			icon: GLMUIThemeExtraIcons glamorousOver;
			order: 25.
			
		self new
			label: 'Step Through';
			action: #stepThrough:;
			icon: GLMUIThemeExtraIcons glamorousThrough;
			order: 30.
	 }
]
