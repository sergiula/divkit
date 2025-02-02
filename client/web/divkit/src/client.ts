import Root from './components/Root.svelte';
import type {
    ComponentCallback,
    CustomActionCallback,
    Customization,
    DivExtensionClass,
    DivJson,
    DivkitInstance,
    ErrorCallback,
    FetchInit,
    Platform,
    StatCallback,
    Theme,
    TypefaceProvider
} from '../typings/common';
import type { GlobalVariablesController } from './expressions/globalVariablesController';
import type { CustomComponentDescription } from '../typings/custom';

export function render(opts: {
    target: HTMLElement;
    json: DivJson;
    id: string;
    hydrate?: boolean;
    globalVariablesController?: GlobalVariablesController;
    mix?: string;
    customization?: Customization;
    builtinProtocols?: string[];
    extensions?: Map<string, DivExtensionClass>;
    onStat?: StatCallback;
    onCustomAction?: CustomActionCallback;
    onError?: ErrorCallback;
    onComponent?: ComponentCallback;
    typefaceProvider?: TypefaceProvider;
    platform?: Platform;
    theme?: Theme;
    fetchInit?: FetchInit;
    tooltipRoot?: HTMLElement;
    customComponents?: Map<string, CustomComponentDescription> | undefined;
}): DivkitInstance {
    const { target, hydrate, ...rest } = opts;

    const instance = new Root({
        target: target,
        props: rest,
        hydrate: hydrate
    });

    return {
        $destroy() {
            instance.$destroy();
        },
        execAction(action) {
            instance.execAction(action);
        },
        setTheme(theme) {
            instance.setTheme(theme);
        },
        setData(newJson) {
            instance.setData(newJson);
        }
    };
}

export {
    createGlobalVariablesController
} from './expressions/globalVariablesController';

export {
    createVariable
} from './expressions/variable';

export {
    SizeProvider
} from './extensions/sizeProvider';

export {
    lottieExtensionBuilder
} from './extensions/lottie';
