<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<b>${message?ifExists}</b>
<@l.login "/login" false/>
</@c.page>