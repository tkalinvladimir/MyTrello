<#import "parts/common.ftl" as c>

<@c.page>

<script type="text/javascript">
    function cardEditText(id, deckid, csrf, text) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardChange', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'id='+id+'&text='+text+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);
    }

    function cardDel(id, deckid, csrf) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardDel', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'card_id='+id+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);

    }

    function cardEditStatus(id, deckid, csrf, status) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardChangeStatus', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'id='+id+'&status='+status+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);
    }
</script>

Deck view
<span>${deck.name}</span>
<br />
Добавить новую карточку
<div>
    <form action="\addCard" method="post" enctype="multipart/form-data">
        <input type="text" name="text" placeholder="Введите текст" />
        <input type="file" name="file">
        <input type="hidden" value="${deck.id}" name="deckId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />

        <select name="deckstatus_id">
            <#if available_statuses??>
                <#list available_statuses as status2>
                    <option value="${status2.id}">${status2.status}</option>
                </#list>
            </#if>
        </select>

        <button type="submit">Добавить</button>
    </form>
</div>

<br />

<div>Список карточек</div>
    <#list cards as card>
    <div>
        <form>
            <input type="hidden" value="${card.id}" name="card_id">
            <input type="text" value="${card.text}" name="card_text" onchange="cardEditText(${card.id}, ${deck.id}, '${_csrf.token}', this.value)">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" value="${deck.id}" name="deckId">
            <select name="cardstatus_id" onchange="cardEditStatus(${card.id}, ${deck.id}, '${_csrf.token}', this.value)">
                <#if available_statuses??>
                    <#list available_statuses as status2>
                        <#if status2.id == card.status.id>
                            <option value="${status2.id}" selected>${status2.status}</option>
                        <#else>
                            <option value="${status2.id}">${status2.status}</option>
                        </#if>
                    </#list>
                </#if>
            </select>
            <div>
                <#if card.fileName??>
                    <img src="/img/${card.fileName}">
                </#if>
            </div>
            <button type="button" onclick="cardDel(${card.id}, ${deck.id}, '${_csrf.token}')">X</button>
        </form>
    </div>
    <#else>
    empty
    </#list>

<br />




</@c.page>