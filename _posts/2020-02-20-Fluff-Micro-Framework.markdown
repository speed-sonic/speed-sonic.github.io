---
layout: post
title:  "我的微框架 Fluff 1.0 发布了"
date:   2019-11-28 15:34:17 +0800
categories: 后端 架构
tags: php
---
我开发的 Fluff Micro Framework 正式发布了，它是一款为 web 应用打造的微框架，整合当今主流的实践标准，使你可以灵活的构建应用程序；Fluff 也是一个多核心框架，用户通过简单的桥接组合，可以轻松的实现适用于不同场景的架构。

## 安装
使用 composer 安装框架
```sh
composer require constanze-standard/fluff:1.0
```
还需要安装 PSR-7 组件，可根据需求自行选择，推荐 [nyholm](https://github.com/Nyholm/psr7) 或 [slim](https://github.com/slimphp/Slim-Psr7) 的组件。

## 应用的初始化
Fluff 在创建应用时，首先需要定义一个`策略`（strategy），Fluff 的内部提供了多种 `RequestHandler` 组件 可以作为初始化的策略，下面是一个基本示例，我们利用一个简单的 `Args` 组件作为策略初始化应用：
```php
use ConstanzeStandard\Fluff\Application;
use ConstanzeStandard\Fluff\RequestHandler\Args;
use Psr\Http\Message\ServerRequestInterface;
use Nyholm\Psr7\Response;

$strategy = new Args(function(ServerRequestInterface $request, $args) {
    return new Response(
        200, [], 'Hello '. $args['name']
    );
}, ['name' => 'Alex']);

$app = new Application($strategy);
```
现在，我们成功创建了应用（`Application`），Args 组件决定了应用程序的运行模式：当我们将 `request` 发送给 `Application` 时，将直接执行 Args 初始化时定义的匿名函数，并将 request 对象和参数传入其中。

以上是一个简单的例子，在实际应用中，Args 组件通常是作为辅助策略，配额其他 `RequestHandler` 使用的，例如，当我们需要使用路由派发策略时，我们可以选择将 Args 组件和 Dispatch 组件进行桥接，以继承 Args 的特性：
```php
use ConstanzeStandard\Fluff\Application;
use ConstanzeStandard\Fluff\RequestHandler\Args;
use ConstanzeStandard\Fluff\RequestHandler\Dispatcher;
use Psr\Http\Message\ServerRequestInterface;
use Nyholm\Psr7\Response;
use Nyholm\Psr7\ServerRequest;

$strategy = new Dispatcher(Args::getDefinition());
$app = new Application($strategy);

$router = $strategy->getRouter();

$router->get('/user/{name}', function(ServerRequestInterface $request, $args) {
    return new Response(200, [], 'Hello '. $args['name']);
});

$request = new ServerRequest('GET', '/user/Alex');
$app->handle($request);
```
路由的 `Dispatcher` 组件不具备处理业务逻辑的能力，所以需要一个额外的策略与它进行配合，这里我们选用了 Args，所以，路由的调用策略也继承了 Args 的运行模式。

## 官方网站
如果你想了解更多有关 Fluff 的使用，可以访问 Fluff Framework [官方网站](https://www.fluff-framework.cn/)

## 支持与贡献
Fluff 是一个正在成长中的开源项目，如果你在使用的过程中找到了任何 BUG，或有希望实现的新功能，请在 Github 仓库提交 Issue 或 pull requests. 请首先查看 Fluff 的[开源项目贡献指南](https://github.com/constanze-standard/fluff/blob/master/CONTRIBUTING.md)
