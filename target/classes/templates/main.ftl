<#import "parts/common.ftl" as c>



<@c.page>

<script type="text/javascript">
    function deckDel(id, csrf) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/deckDel', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'deck_id='+id+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);
    }
</script>

<h5><b>Список досок</b></h5>
    <#list decks as deck>
    <div class="mt-3 ml-5">
        <h5><b>${deck.name}</b></h5>
        <span>${deck.id}</span>
        <span>${deck.userName}</span>
        <td><a href="/deck_view/${deck.id}">go</a></td>
        <td><a href="/deck/${deck.id}">edit</a></td>
        <button type="button" class="btn-primary ml-2 mt-2" onclick="deckDel(${deck.id},'${_csrf.token}')">X</button>
    </div>
    <#else>
    empty
    </#list>

</br>


<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new deck
</a>
<div class="collapse mt-2" id="collapseExample">
    <div class="form-group">
        <form method="post">
            <input type="text" class = "form-control" name="name" placeholder="Введите название доски" />
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type="submit" class="btn-primary ml-2 mt-2">Добавить</button>
        </form>
    </div>
</div>

</@c.page>