from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTests(TestCase):
    """Class for various model related tests"""

    def test_create_user_with_email_successfully(self):
        """Test creating a new user with an email is successful"""
        email = 'test@test.com'
        password = 'testpassword123'
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        """Test the email for a new user is normalized"""
        email = "test@TEST.COM"
        user = get_user_model().objects.create_user(
            email=email,
            password="password"
        )

        self.assertEqual(user.email, email.lower())

    def test_new_user_invalid_email(self):
        """Test creating user with no email raises error"""
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, "password")

    def test_create_new_superuser(self):
        """"Test creating new superuser"""
        user = get_user_model().objects.create_superuser(
            'admin@test.com',
            'test123'
        )

        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
