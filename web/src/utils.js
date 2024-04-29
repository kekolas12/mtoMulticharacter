const IsEnvBrowser = () => !window.invokeNative;

const CreateNuiEventListener = (func) => {
    window.addEventListener('message', event => func(event));
};

const SendPost = (name, data) => {
    fetch(`https://${GetParentResourceName()}/${name}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
};

export {
    IsEnvBrowser,
    SendPost,
    CreateNuiEventListener
};