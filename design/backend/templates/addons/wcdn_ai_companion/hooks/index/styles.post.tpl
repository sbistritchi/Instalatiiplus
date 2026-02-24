<style>
{literal}
	.circular-border 
	{
		width: 30px;
		height: 30px;
		border-radius: 50%;
		
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
		cursor:pointer;
	}

	.circular-border::before 
	{
		content: '';
		width: 24px;
		height: 24px;
		background: white;
		border-radius: 50%;
		position: absolute;
	}

	.circular-border span 
	{
		position: relative;
		font-size: 11px;
		font-weight: bold;
	}
{/literal}
</style>