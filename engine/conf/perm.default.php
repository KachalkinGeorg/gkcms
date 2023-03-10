<?php

// Default PERMISSIONS
$confPerm = [
    // Administrator
    '1'     => [
        'nsm'       => [
            ''      => [
                'add'                       => true,
                'list'                      => true,
                'view'                      => true,
                'view.draft'                => true,
                'view.unpublished'          => true,
                'view.published'            => true,
                'modify.draft'              => true,
                'modify.unpublished'        => true,
                'modify.published'          => true,
                'delete.draft'              => true,
                'delete.unpublished'        => true,
                'delete.published'          => true,
            ],
        ],
        '#admin'    => [
            'system'        => [
                'admpanel.view'         => true,
                'lockedsite.view'       => true,
                'debug.view'            => true,
                '*'                     => true,
            ],
            'configuration'     => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'cron'  => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'rewrite'   => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'news'      => [
                'view'                          => true,
                'add'                           => true,
                'add.mainpage'                  => true,
                'add.pinned'                    => true,
                'add.catpinned'                 => true,
                'add.favorite'                  => true,
                'add.html'                      => true,
                'add.raw'                       => false,
                'personal.list'                 => true,
                'personal.view'                 => true,
                'personal.modify'               => true,
                'personal.modify.published'     => true,
                'personal.publish'              => true,
                'personal.unpublish'            => true,
                'personal.delete'               => true,
                'personal.delete.published'     => true,
                'personal.html'                 => true,
                'personal.mainpage'             => true,
                'personal.pinned'               => true,
                'personal.catpinned'            => true,
                'personal.favorite'             => true,
                'personal.setviews'             => true,
                'personal.multicat'             => true,
                'personal.nocat'                => true,
                'personal.customdate'           => true,
                'personal.altname'              => true,
                'other.list'                    => true,
                'other.view'                    => true,
                'other.modify'                  => true,
                'other.publish'                 => true,
                'other.unpublish'               => true,
                'other.modify.published'        => true,
                'other.delete'                  => true,
                'other.delete.published'        => true,
                'other.html'                    => true,
                'other.mainpage'                => true,
                'other.pinned'                  => true,
                'other.catpinned'               => true,
                'other.favorite'                => true,
                'other.setviews'                => true,
                'other.multicat'                => true,
                'other.nocat'                   => true,
                'other.customdate'              => true,
                'other.altname'                 => true,
                '*'                             => true,
            ],
            'static' => [
                'view'    => true,
                'details' => true,
                'modify'  => true,
            ],
            'users' => [
                'view'    => true,
                'details' => true,
                'modify'  => true,
            ],
            'categories'    => [
                'view'                      => true,
                'modify'                    => true,
                'details'                   => true,
            ],
            'ipban'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'templates'     => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'rules'     => [
                'details'           => true,
                'modify'            => true,
            ],
            'perm'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'ugroup'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'dbo'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'extras'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'extra-config'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'statistics'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'editcomments'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'options'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'files'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'images'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'pm'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'preview'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            'docs'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
            '*'             => [
                '*'             => true,
            ],
        ],
        '*'     => [
            '*'         => [
                '*'         => true,
            ],
        ],
    ],

    // Editor
    '2'     => [
        '#admin'    => [
            'news'      => [
                'view'                          => true,
                'add'                           => true,
                'add.mainpage'                  => true,
                'add.pinned'                    => true,
                'add.catpinned'                 => true,
                'add.favorite'                  => false,
                'add.raw'                       => false,
                'add.html'                      => false,
                'personal.list'                 => true,
                'personal.view'                 => true,
                'personal.modify'               => true,
                'personal.modify.published'     => true,
                'personal.publish'              => true,
                'personal.unpublish'            => true,
                'personal.delete'               => true,
                'personal.delete.published'     => true,
                'personal.html'                 => false,
                'personal.mainpage'             => true,
                'personal.pinned'               => true,
                'personal.catpinned'            => true,
                'personal.favorite'             => true,
                'personal.setviews'             => true,
                'personal.nocat'                => true,
                'personal.multicat'             => true,
                'personal.customdate'           => true,
                'personal.altname'              => true,
                'other.list'                    => true,
                'other.view'                    => true,
                'other.modify'                  => true,
                'other.publish'                 => true,
                'other.unpublish'               => true,
                'other.modify.published'        => true,
                'other.delete'                  => true,
                'other.delete.published'        => true,
                'other.html'                    => false,
                'other.mainpage'                => true,
                'other.pinned'                  => true,
                'other.catpinned'               => true,
                'other.favorite'                => true,
                'other.setviews'                => true,
                'other.multicat'                => true,
                'other.nocat'                   => true,
                'other.customdate'              => true,
                'other.altname'                 => true,
                '*'                             => false,
            ],
            'static' => [
                'view'    => false,
                'details' => false,
                'modify'  => false,
            ],
            'categories'    => [
                'view'                      => true,
                'modify'                    => true,
                'details'                   => true,
            ],
            'ipban'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'files'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'images'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'pm'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'preview'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'docs'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
        ],
    ],

    // Journalist
    '3'     => [
        '#admin'    => [
            'news'      => [
                'view'                          => true,
                'add'                           => true,
                'add.mainpage'                  => false,
                'add.pinned'                    => false,
                'add.catpinned'                 => false,
                'add.favorite'                  => false,
                'add.raw'                       => false,
                'add.html'                      => false,
                'personal.list'                 => true,
                'personal.view'                 => true,
                'personal.modify'               => true,
                'personal.modify.published'     => true,
                'personal.publish'              => false,
                'personal.unpublish'            => true,
                'personal.delete'               => true,
                'personal.delete.published'     => true,
                'personal.html'                 => false,
                'personal.mainpage'             => false,
                'personal.pinned'               => false,
                'personal.catpinned'            => false,
                'personal.favorite'             => false,
                'personal.setviews'             => false,
                'personal.nocat'                => true,
                'personal.multicat'             => true,
                'personal.customdate'           => false,
                'personal.altname'              => true,
                '*'                             => false,
            ],
            'categories'    => [
                'view'                      => true,
                'modify'                    => false,
                'details'                   => false,
            ],
            'ipban'     => [
                'view'                      => false,
                'modify'                    => false,
            ],
            'files'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'images'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'pm'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'preview'     => [
                'view'                      => true,
                'modify'                    => true,
            ],
            'docs'          => [
                'details'           => true,
                'modify'            => true,
                '*'                 => true,
            ],
        ],
    ],

    // Commentor
    '4'     => [
        '#admin'    => [
            'news'      => [
                '*'                             => false,
            ],

        ],
    ],
];
