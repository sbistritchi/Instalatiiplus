{assign var="id" value=$id|default:"quickcheckout_login"}

{capture name="login"}
    <form name="{$id}_form" action="{""|fn_url}" method="post">
	
        <div class="ty-control-group">
            <label for="login_{$id}" class="ty-login__filed-label ty-control-group__label cm-required cm-trim cm-email">{__("email")}</label>
            <input type="text" id="login_{$id}" name="user_login" size="30" value="{$config.demo_username}" class="ty-login__input cm-focus" />
        </div>

        <div class="ty-control-group ty-password-forgot">
            <label for="psw_{$id}" class="ty-login__filed-label ty-control-group__label ty-password-forgot__label cm-required">{__("password")}</label><a href="{"auth.recover_password"|fn_url}" class="ty-password-forgot__a"  tabindex="5">{__("forgot_password_question")}</a>
            <input type="password" id="psw_{$id}" name="password" size="30" class="ty-login__input" maxlength="32" />
        </div>


        {include file="common/image_verification.tpl" option="login" align="left"}



        {hook name="index:login_buttons"}
            <div class="buttons-container clearfix">
                <div class="ty-float-right">
					{include file="buttons/button.tpl" but_href="{"quickcheckout.create_account"|fn_url}" but_meta="ty-btn__secondary" but_text=__("register")}
                    {include file="buttons/login.tpl" but_name="dispatch[quickcheckout.login]" but_role="submit"}
                </div>
            </div>
        {/hook}
    </form>
{/capture}

{if $style == "popup"}
    {$smarty.capture.login nofilter}
{else}
    <div class="ty-login">
        {$smarty.capture.login nofilter}
    </div>

    {capture name="mainbox_title"}{__("sign_in")}{/capture}
{/if}
