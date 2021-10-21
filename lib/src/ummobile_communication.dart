import 'package:ummobile_sdk/src/models/communication/post.dart';
import 'package:ummobile_sdk/src/statics.dart';
import 'package:ummobile_custom_http/ummobile_custom_http.dart';
import 'package:ummobile_sdk/ummobile_sdk.dart';

/// A client for the UMMobile API institutional communication section requests.
class UMMobileCommunication {
  /// The API client.
  UMMobileCustomHttp _http;

  /// The path of the requests group.
  static final String path = 'communication';

  /// Main UMMobile communication client constructor.
  ///
  /// Require the [token] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  UMMobileCommunication({
    required String token,
    String version: latestVersion,
  }) : this._http = UMMobileCustomHttp(
          baseUrl: '$host/$version/$path',
          auth: Auth(
            token: () => token,
            tokenType: 'Bearer',
            headerName: 'Authorization',
          ),
        );

  /// Retrieve a list of the university news.
  ///
  /// An specific [quantity] of posts can be defined.
  Future<List<Post>> getNews({int? quantity}) {
    return this._http.customGet<List<Post>>(
          path: '/news',
          queries: {
            if (quantity != null) 'quantity': quantity,
          },
          mapper: (json) => List.from(json)
              .map((post) => Post(
                    title: post['title'],
                    image: post['image'],
                    url: post['url'],
                  ))
              .toList(),
        );
  }

  /// Retrieve a list of the university events.
  ///
  /// An specific [quantity] of posts can be defined.
  Future<List<Post>> getEvents({int? quantity}) {
    return this._http.customGet<List<Post>>(
          path: '/events',
          queries: {
            if (quantity != null) 'quantity': quantity,
          },
          mapper: (json) => List.from(json)
              .map((post) => Post(
                    title: post['title'],
                    image: post['image'],
                    url: post['url'],
                  ))
              .toList(),
        );
  }

  /// Retrieve a list of the university blog posts.
  ///
  /// An specific [quantity] of posts can be defined.
  Future<List<Post>> getBlogPosts({int? quantity}) {
    return this._http.customGet<List<Post>>(
          path: '/blog',
          queries: {
            if (quantity != null) 'quantity': quantity,
          },
          mapper: (json) => List.from(json)
              .map((post) => Post(
                    title: post['title'],
                    image: post['image'],
                    url: post['url'],
                  ))
              .toList(),
        );
  }

  /// Retrieve a list of institutional groups with his stories.
  Future<List<Group>> getStories() {
    return this._http.customGet<List<Group>>(
          path: '/stories',
          mapper: (json) => List.from(json)
              .map((group) => Group(
                    name: group['name'],
                    image: group['image'],
                    stories: List.from(group['stories'])
                        .map((story) => Story(
                              startDate: story['startDate'],
                              endDate: story['endDate'],
                              duration: story['duration'],
                              type: story['type'],
                              content: story['content'],
                            ))
                        .toList(),
                  ))
              .toList(),
        );
  }
}
