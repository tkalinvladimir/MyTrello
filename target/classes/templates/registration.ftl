<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
Add new user
<b>${some?ifExists}</b>
    <@l.login "/registration" />
</@c.page>