import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/guide.dart';
import '../models/group.dart';
import '../models/message.dart';
import '../models/payment_method.dart';
import '../models/safety_alert.dart';
import '../models/trip.dart';

/// Central repository for placeholder content powering the UI screens.
class DummyContent {
  static const trips = <Trip>[
    Trip(
      title: 'Dunes Sunrise Caravan',
      location: 'Merzouga, Morocco',
      duration: '4 days',
      price: 420,
      image: 'assets/images/trip_1.png',
    ),
    Trip(
      title: 'Nomad Wellness Retreat',
      location: 'Zagora, Morocco',
      duration: '3 days',
      price: 360,
      image: 'assets/images/trip_2.png',
    ),
    Trip(
      title: 'Oasis Stargazing Escape',
      location: 'Tozeur, Tunisia',
      duration: '2 days',
      price: 280,
      image: 'assets/images/trip_3.png',
    ),
  ];

  static const events = <CulturalEvent>[
    CulturalEvent(
      title: 'Amazigh Music Night',
      location: 'Douz Oasis',
      date: '12 Nov',
      description:
          'Traditional poetry, desert drums, and shared couscous tables.',
    ),
    CulturalEvent(
      title: 'Date Palm Harvest',
      location: 'Tozeur Palmgrove',
      date: '18 Nov',
      description: 'Harvest premium deglet nour dates with local farmers.',
    ),
    CulturalEvent(
      title: 'Sand Boarding Jam',
      location: 'Erg Chebbi',
      date: '22 Nov',
      description:
          'Carve sunrise dunes and learn safety tips from expert guides.',
    ),
  ];

  static const guides = <Guide>[
    Guide(
      name: 'Amine Ben Salah',
      role: 'Lead Desert Navigator',
      rating: 4.9,
      reviewCount: 268,
      avatar: 'assets/images/guide_amine.png',
    ),
    Guide(
      name: 'Leila Aït',
      role: 'Mindful Trek Facilitator',
      rating: 4.8,
      reviewCount: 194,
      avatar: 'assets/images/guide_leila.png',
    ),
    Guide(
      name: 'Said El Mansour',
      role: 'Cultural Storyteller',
      rating: 4.7,
      reviewCount: 156,
      avatar: 'assets/images/guide_said.png',
    ),
  ];

  static const groups = <TravelGroup>[
    TravelGroup(
      name: 'Merzouga Sunrise Circle',
      region: 'Merzouga, Morocco',
      dateRange: '21 - 24 Nov',
      membersJoined: 6,
      membersTotal: 10,
      price: 320,
      highlight: 'Astronomy walks & mint tea rituals',
      status: GroupStatus.fillingFast,
    ),
    TravelGroup(
      name: 'Nomad Wellness Series',
      region: 'Zagora, Morocco',
      dateRange: '02 - 05 Dec',
      membersJoined: 4,
      membersTotal: 8,
      price: 345,
      highlight: 'Breathwork + hammam recovery',
      status: GroupStatus.open,
    ),
    TravelGroup(
      name: 'Oasis Stargazers',
      region: 'Tozeur, Tunisia',
      dateRange: '11 - 13 Dec',
      membersJoined: 9,
      membersTotal: 12,
      price: 290,
      highlight: 'Dune boarding & quad explorations',
      status: GroupStatus.lastCall,
    ),
  ];

  static const paymentMethods = <PaymentMethod>[
    PaymentMethod(
      name: 'Khalti',
      description: 'Instant digital wallet popular across South Asia.',
      icon: Icons.account_balance_wallet_outlined,
    ),
    PaymentMethod(
      name: 'eSewa',
      description: 'Trusted for Nepal and India payments.',
      icon: Icons.phone_iphone,
    ),
    PaymentMethod(
      name: 'Stripe',
      description: 'Cards, Apple Pay, Google Pay, and more.',
      icon: Icons.credit_card,
    ),
  ];

  static const safetyAlerts = <SafetyAlert>[
    SafetyAlert(
      title: 'Sandstorm Waning',
      message:
          'Visibility improving in Douz. Resume travel after 14:30 with goggles.',
      type: SafetyAlertType.weather,
    ),
    SafetyAlert(
      title: 'Route Checkpoint Reached',
      message: 'Wellness caravan checked into Oasis station Bravo.',
      type: SafetyAlertType.route,
    ),
    SafetyAlert(
      title: 'Heat Advisory',
      message: 'Hydrate every 30 minutes between 12:00 and 15:00.',
      type: SafetyAlertType.health,
    ),
  ];

  static final chatHistory = <ChatMessage>[
    ChatMessage(
      id: '1',
      sender: 'Amine',
      text: 'Salam! Ready for tomorrow’s sunrise trek?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isMe: false,
    ),
    ChatMessage(
      id: '2',
      sender: 'You',
      text: 'Absolutely! Any gear I should pack?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 13)),
      isMe: true,
    ),
    ChatMessage(
      id: '3',
      sender: 'Amine',
      text:
          'Bring a scarf, reusable bottle, and sunscreen. I have spare goggles.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 11)),
      isMe: false,
    ),
  ];
}
