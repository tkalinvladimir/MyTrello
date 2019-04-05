<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<div>
    <@l.logout />
    <span><a href="/user">User list</a></span>
</div>
<div>
    <form method="post">
        <input type="text" name="name" placeholder="Введите название доски" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit">Добавить</button>
    </form>
</div>
<div>Список досок</div>
    <#list decks as deck>
    <div>
        <b>${deck.id}</b>
        <span>${deck.name}</span>
        <strong>${deck.userName}</strong>
        <td><a href="/deck/${deck.id}">edit</a></td>
        <td><a href="/deck_view/${deck.id}">go</a></td>
    </div>
    <#else>
    empty
    </#list>
</@c.page>